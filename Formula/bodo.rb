# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1124.4766/bodo-darwin-arm64"
  version "2026.1124.4766"
  sha256 "6f63cfe6a7c8f19f26c7cf4f1876402e8f12d1b43e3676d4f05f7314f4e9285b"
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
      url "https://cli.bodo-app.com/v/2026.1124.4766/bodo-linux-arm64"
      sha256 "168f1c83691d44b3257164d7c08cc04e3b5f9fff8cef314a405c8bf76acbd4b5"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1124.4766/bodo-linux-x64"
      sha256 "4dab80c9e3b952cc7118e704f67302c9edb0efe393b25415f0686f254152bf7b"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
