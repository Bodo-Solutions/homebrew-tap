# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1115.4736/bodo-darwin-arm64"
  version "2026.1115.4736"
  sha256 "c3dd542bd25f0b82159f70b1303770db16279b66f99fcac1f891710465ff38c5"
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
      url "https://cli.bodo-app.com/v/2026.1115.4736/bodo-linux-arm64"
      sha256 "e149376850087f3e9ee092ed02560f1deade4ecf0afc29f7e803cb4efb0e0031"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1115.4736/bodo-linux-x64"
      sha256 "c4fc838ae7f2e5df65c82cce8137f4c0d61ddadef2af8476fb858e04487abce9"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
