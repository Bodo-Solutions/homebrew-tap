# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1011.3860/bodo-darwin-arm64"
  version "2026.1011.3860"
  sha256 "c68c2727b3248d0c477377eeeaf62cbbe8afe832656b8cdcf340a0d099e601fd"
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
      url "https://cli.bodo-app.com/v/2026.1011.3860/bodo-linux-arm64"
      sha256 "1bc008388f86f60c35fc2873523ddf282affc4e0e3afad537e922ae9c38da86e"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1011.3860/bodo-linux-x64"
      sha256 "b54f825fdb030c65949e05ad9e40a53e38e7fdbf29f18db3ac66082a2faa543e"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
