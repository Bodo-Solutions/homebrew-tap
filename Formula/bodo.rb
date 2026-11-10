# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1110.4719/bodo-darwin-arm64"
  version "2026.1110.4719"
  sha256 "d4e86d07c3dd7a446109310c4f1d3be3d6aefc4dfc7ae762c5862f11bb64e029"
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
      url "https://cli.bodo-app.com/v/2026.1110.4719/bodo-linux-arm64"
      sha256 "593ced0712d96319c84239b96ed33e0f1d73112a543ec236e7d200a7e0235f5f"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1110.4719/bodo-linux-x64"
      sha256 "f9d74d864707c77a0caebbd2fa6e81fe7857b969e0dceba4ae85a402bf3aa9ae"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
