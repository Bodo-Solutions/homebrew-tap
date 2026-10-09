# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1009.3802-rc/bodo-darwin-arm64"
  version "2026.1009.3802-rc"
  sha256 "540b47879cd777293a73ef5f6511baeb8d7a21e0bcea59823c3f71e941fcf27b"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/rc/manifest.json"
    regex(/^v?(\d+(?:\.\d+)+(?:-rc)?)$/i)
    strategy :json do |json, regex|
      json["version"]&.[](regex, 1)
    end
  end

  on_macos do
    depends_on arch: :arm64 unless Hardware::CPU.in_rosetta2?
  end

  on_linux do
    on_arm do
      url "https://cli.bodo-app.com/v/2026.1009.3802-rc/bodo-linux-arm64"
      sha256 "9e687bd51a35df8bd63dbe5fd137fab3220f6cf9a9ca03d650225c48b512b0ba"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1009.3802-rc/bodo-linux-x64"
      sha256 "dff603ec82598b8e6c9383c0f6920324c45682b6027c0c6437ebf294ad4a1f4b"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
