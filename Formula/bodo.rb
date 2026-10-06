# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1006.3687/bodo-darwin-arm64"
  version "2026.1006.3687"
  sha256 "0405ec04c55848f2641e567fcaa7e3cb65f6e21d05c198f1140da8d82bd10b59"
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
      url "https://cli.bodo-app.com/v/2026.1006.3687/bodo-linux-arm64"
      sha256 "27d4c7716e34b24de9f43072dd0fef757a1637d66ad7d3333668eaacb1ccf346"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1006.3687/bodo-linux-x64"
      sha256 "e833627da5ec93e0165b37bbea370d11125eafbb115ceec9a2f119bc46d087da"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
