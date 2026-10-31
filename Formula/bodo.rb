# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1031.4686/bodo-darwin-arm64"
  version "2026.1031.4686"
  sha256 "ff7148bfe3cf20b8c3b047e6e0318fba2c132e5678f76e09ed45f0459611a204"
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
      url "https://cli.bodo-app.com/v/2026.1031.4686/bodo-linux-arm64"
      sha256 "541b42f2c35b4efdca06ebcca5e8b6bd84ae3fff833f5762e77fdcaeac63219c"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1031.4686/bodo-linux-x64"
      sha256 "b75a8956b2a2bc0cd8b114a92fa0ecca8f07c03ecab946499355e4114569acc6"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
