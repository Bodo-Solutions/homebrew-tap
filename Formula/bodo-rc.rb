# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1029.4563-rc/bodo-darwin-arm64"
  version "2026.1029.4563-rc"
  sha256 "09cac907ed69ec5dbcea0b81b2039c831a76eddd753e8cd6fa3e1d172e29c887"
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
      url "https://cli.bodo-app.com/v/2026.1029.4563-rc/bodo-linux-arm64"
      sha256 "722ca2ce1df4ce8f01d274efae0d952f1389eb329d00f60a7b47343bdcffb7c5"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1029.4563-rc/bodo-linux-x64"
      sha256 "f8c145df655b2db0d34f6b654de7ac6c60dc77a821608b009e3d29469d10804e"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
