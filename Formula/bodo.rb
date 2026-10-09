# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1009.3777/bodo-darwin-arm64"
  version "2026.1009.3777"
  sha256 "a8b773b7e1195f925a03cb47d622817f0b4e87607e805f67fd165846c1f67bfc"
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
      url "https://cli.bodo-app.com/v/2026.1009.3777/bodo-linux-arm64"
      sha256 "e0227840d00ed0fe941bd6e1da113db79c017b8bae17689636f86c46d872fc07"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1009.3777/bodo-linux-x64"
      sha256 "7bf4c35c6651d1ba0134930c91e5cc5ebc312d15dfcd126528814fec35a3fc92"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
