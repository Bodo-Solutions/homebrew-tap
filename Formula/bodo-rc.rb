# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1026.4431-rc/bodo-darwin-arm64"
  version "2026.1026.4431-rc"
  sha256 "cec2979fffad018b100f822f5468376d30a98e0be8455f536d917cf3a5a5bd35"
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
      url "https://cli.bodo-app.com/v/2026.1026.4431-rc/bodo-linux-arm64"
      sha256 "30c780ae4760ce35b98f00ad36756562b7fddec49215969af3a1f7b80e865064"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1026.4431-rc/bodo-linux-x64"
      sha256 "5accb1eed1423665ce7d8d89f37247af96bbc56b02aa66138846912b333a2f90"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
