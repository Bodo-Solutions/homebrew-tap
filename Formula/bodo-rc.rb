# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4326-rc/bodo-darwin-arm64"
  version "2026.1024.4326-rc"
  sha256 "40fba5006bacaef7be22d9ad3b67786e8718ac79a209d35a42edda894f33da34"
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
      url "https://cli.bodo-app.com/v/2026.1024.4326-rc/bodo-linux-arm64"
      sha256 "740d2c842438482426f361f92444c398fbe3eea99bc22e5b45daec2b870cc50c"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4326-rc/bodo-linux-x64"
      sha256 "a2a50042cae187fd4c5efaf1e03824cd71557cc91333d700dae084766c5d38c2"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
