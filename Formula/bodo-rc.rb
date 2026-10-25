# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1025.4386-rc/bodo-darwin-arm64"
  version "2026.1025.4386-rc"
  sha256 "28f0c8ec0143df7d895a0947f96b75e95e689d5858bb125c4d7cc6f46fcbb9cb"
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
      url "https://cli.bodo-app.com/v/2026.1025.4386-rc/bodo-linux-arm64"
      sha256 "17bca0243fdbb3dccdb6c4794d89159fc8b7013c839aa36f5863d01c2bca5f56"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1025.4386-rc/bodo-linux-x64"
      sha256 "48f13010a5c964392f3b37750818c40635a696748ff2693432b9334b0e2a1d01"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
