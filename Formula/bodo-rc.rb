# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1025.4406-rc/bodo-darwin-arm64"
  version "2026.1025.4406-rc"
  sha256 "7921fb22022ba9106b50693110e7483a466296574ae0bc92129d9cd956278b10"
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
      url "https://cli.bodo-app.com/v/2026.1025.4406-rc/bodo-linux-arm64"
      sha256 "cd06459e9e1f37e0cb2786c68b91e5a6432f5f3d98143a5d4c85271bc0d76801"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1025.4406-rc/bodo-linux-x64"
      sha256 "e46cb79035558d1bbc575f39cc2a461706a2bb8f9fa56599ded6b06d32e2cf00"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
