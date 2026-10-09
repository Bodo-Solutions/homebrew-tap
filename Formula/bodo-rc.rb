# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1009.3771-rc/bodo-darwin-arm64"
  version "2026.1009.3771-rc"
  sha256 "97c3592227232a55ef416ec52c686735d3956e83e6fd5bf12cc6687e4057ce68"
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
      url "https://cli.bodo-app.com/v/2026.1009.3771-rc/bodo-linux-arm64"
      sha256 "c7f41ec58b87cee7f10f9327a03aae5171191b208c9ed2ce5fcf2d51441f1f48"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1009.3771-rc/bodo-linux-x64"
      sha256 "9d1b62d0f7c5d0e312dd3ef470d47ba768129662c216fddc1e200ace38036612"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
