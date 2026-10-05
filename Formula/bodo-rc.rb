# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1005.3624-rc/bodo-darwin-arm64"
  version "2026.1005.3624-rc"
  sha256 "136abb9d89cab1eb0eba1c7d1e0a18ea8a0e1189af9f9cb42ecbe50368695134"
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
      url "https://cli.bodo-app.com/v/2026.1005.3624-rc/bodo-linux-arm64"
      sha256 "a9ac200b4f07e70558b878a301b3880c7871571f99906519f479884d72f880af"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1005.3624-rc/bodo-linux-x64"
      sha256 "b071a3fd47c6b8134b462b20cb80d9f6166100e825723e03e3d3c0b50676db38"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
