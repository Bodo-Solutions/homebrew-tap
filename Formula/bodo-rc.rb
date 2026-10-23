# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1023.4279-rc/bodo-darwin-arm64"
  version "2026.1023.4279-rc"
  sha256 "c728889488e8ef1e387773463fd23cb3b12ae0e3c7318ca747d3de17352a592a"
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
      url "https://cli.bodo-app.com/v/2026.1023.4279-rc/bodo-linux-arm64"
      sha256 "cfeb71b398ab1971cebd9a237f6d61a9b343f4c2339c33ca562986ffc109ad15"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1023.4279-rc/bodo-linux-x64"
      sha256 "573bd72061e57c508c4e3617663e15526c78f3cd61c7075d450da03ae92c2aab"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
