# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1104.4699/bodo-darwin-arm64"
  version "2026.1104.4699"
  sha256 "af6ab3d61f6d45f37ff2085a5ee3ddc3ab21fba4dc74959e0cff8c4afe1130c0"
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
      url "https://cli.bodo-app.com/v/2026.1104.4699/bodo-linux-arm64"
      sha256 "2445171e4c1c4a6eb552059d71b687cd453a8f308b1bcac0f56e5a736281f756"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1104.4699/bodo-linux-x64"
      sha256 "76e9666a3421a57e190a101e6c59009ad48f77f0ab9ea24ac3f335b2d55b00cf"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
