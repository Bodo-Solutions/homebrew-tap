# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1021.4185-rc/bodo-darwin-arm64"
  version "2026.1021.4185-rc"
  sha256 "0c482f5dd8ec961d7fe14378b7e2b6baac48165462888eca744913b6ed7d5ea3"
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
      url "https://cli.bodo-app.com/v/2026.1021.4185-rc/bodo-linux-arm64"
      sha256 "2d21dd854fc2d269fd68b94ade90976a907d839670c58da22a629b0dd3a5049e"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1021.4185-rc/bodo-linux-x64"
      sha256 "c1a3bf2daa374b4fc47aa620bd5765ea4041a34216e0a95bf826a27f525377fe"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
