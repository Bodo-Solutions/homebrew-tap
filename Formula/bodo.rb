# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1107.4706/bodo-darwin-arm64"
  version "2026.1107.4706"
  sha256 "b3537381bb574830b2cd17d79c8b6ff22de1a0701bf04907733952ff96e69f0a"
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
      url "https://cli.bodo-app.com/v/2026.1107.4706/bodo-linux-arm64"
      sha256 "36e2d3baa265bba044e174d3915b1f291c59e29ec3b4749a81daa29287de069f"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1107.4706/bodo-linux-x64"
      sha256 "2802f5e11624cd50c69338e42b9bbdf4ca91c6b6fb120096b81fae9b9f361716"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
