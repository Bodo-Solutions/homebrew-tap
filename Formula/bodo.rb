# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4362/bodo-darwin-arm64"
  version "2026.1024.4362"
  sha256 "2168f537d2ca234b120af8a9d43bb104c6fae4a02cfcb5c8446847e431e65bdd"
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
      url "https://cli.bodo-app.com/v/2026.1024.4362/bodo-linux-arm64"
      sha256 "24d4a95f7aa791d88b164711b23956c903b8689f07f9a48cd8546d79e03db324"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4362/bodo-linux-x64"
      sha256 "e28a39022f91ecb68d3500836aa12f314f59693d12a288d737346c6796f15b7b"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
