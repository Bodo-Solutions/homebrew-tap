# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1108.4712/bodo-darwin-arm64"
  version "2026.1108.4712"
  sha256 "1e12053077bc131cdab27bdb8012f46de960d20430403f41cd4429192bc44a38"
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
      url "https://cli.bodo-app.com/v/2026.1108.4712/bodo-linux-arm64"
      sha256 "d7ec5912b98098039c108679e0c161da6e5d31cf022a4ef3241a4a0cf7928a54"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1108.4712/bodo-linux-x64"
      sha256 "1c78704114a39cf334e09953ed4df31d68428d1fbc61aecf5c94895d7f8bcc53"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
