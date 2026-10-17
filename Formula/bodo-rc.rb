# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1017.4030-rc/bodo-darwin-arm64"
  version "2026.1017.4030-rc"
  sha256 "b32cf8b8c2d1947962c710ee8dc42fa2edcc9001fea658de8945775831ec5288"
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
      url "https://cli.bodo-app.com/v/2026.1017.4030-rc/bodo-linux-arm64"
      sha256 "74150a7338fbf4af76ca3a87d9e02369b6fe7490172204238670ef32e805ec07"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1017.4030-rc/bodo-linux-x64"
      sha256 "481ca4f079e2929621b4a93c59b3c0eb2f1175e8c8bb4582fb491af71c942389"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
