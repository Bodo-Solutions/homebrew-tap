# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1108.4710/bodo-darwin-arm64"
  version "2026.1108.4710"
  sha256 "40f2ea8797824250f15936f725dd22853f38858f919d66cfcaca27abcee4cf12"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/stable/manifest.json"
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
      url "https://cli.bodo-app.com/v/2026.1108.4710/bodo-linux-arm64"
      sha256 "593a620c8f52e7f3037dc4f35606647594e02b6176bfe2623d0d88066be2a029"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1108.4710/bodo-linux-x64"
      sha256 "416ce178d60222dec96b4399ebc0660ad079320f5b3fcdea87031b752981bf70"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
