# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1004.3602-rc/bodo-darwin-arm64"
  version "2026.1004.3602-rc"
  sha256 "3afb57e93a20a6a8bfd774202a3b44811e5182a973c96e0174113647ba7bc97c"
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
      url "https://cli.bodo-app.com/v/2026.1004.3602-rc/bodo-linux-arm64"
      sha256 "a855e5d4bc407f4be3b422b3b01a836968fcb22687fe6db7be5e57ad112031ca"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1004.3602-rc/bodo-linux-x64"
      sha256 "1fb27b498cd72d8f88550ac7b0884972b97f6ef6fd2d621e0874057d97ee2d42"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
