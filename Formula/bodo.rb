# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1111.4723/bodo-darwin-arm64"
  version "2026.1111.4723"
  sha256 "ca6bbb7a023afd561ae09c163fe47746efee965856b784693547307af79dacaf"
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
      url "https://cli.bodo-app.com/v/2026.1111.4723/bodo-linux-arm64"
      sha256 "00b2c57bcb33a11fdce53d4a796941da0b4d7d68c784e1948ed2d5e2bd9539c1"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1111.4723/bodo-linux-x64"
      sha256 "a0df1083626eae4b730a321430d4172e343112040cec76bdca5a55b90cdbf939"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
