# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4330-rc/bodo-darwin-arm64"
  version "2026.1024.4330-rc"
  sha256 "83f08312e37e4fa0d40e82f4a462a54cc2a8b0f0bd2c082e716df5d314276444"
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
      url "https://cli.bodo-app.com/v/2026.1024.4330-rc/bodo-linux-arm64"
      sha256 "fe82540d96ac0a595c233deed5e22f3ec8fbf696b53f67057665efb1d8130882"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4330-rc/bodo-linux-x64"
      sha256 "782a400c8c20ecb5102228180a548b0b24350bf8be219e13d2ad72664ff04971"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
