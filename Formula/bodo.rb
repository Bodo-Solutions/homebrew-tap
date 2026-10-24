# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4336/bodo-darwin-arm64"
  version "2026.1024.4336"
  sha256 "d68bb5a28c6b3e7579b348d5853f6140e3d011c1f10f5d1e15cbc7ea5b1a36e3"
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
      url "https://cli.bodo-app.com/v/2026.1024.4336/bodo-linux-arm64"
      sha256 "3751e7635412d08d23d2cdbfdb2a2cd5620b7f23615b122dbd872ea638ee7785"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4336/bodo-linux-x64"
      sha256 "951322315474da3f411476081feea97b2b684a5b88e948a6c2ddde3e94e929eb"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
