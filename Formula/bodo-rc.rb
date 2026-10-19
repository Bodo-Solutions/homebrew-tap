# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1019.4065-rc/bodo-darwin-arm64"
  version "2026.1019.4065-rc"
  sha256 "e180501d309308d8ef824fa6535e2d2771cc7b8dab77e21021228eeb32f9f696"
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
      url "https://cli.bodo-app.com/v/2026.1019.4065-rc/bodo-linux-arm64"
      sha256 "d14938fb47bcd5eab39f16b1b94ecf2be664b9a496a1527dc2a90a59119b1463"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1019.4065-rc/bodo-linux-x64"
      sha256 "ddbe56d6b82f1970ec6fb892c4ab0a489a1e328b5846b47ed6304f5f8cd197d6"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
