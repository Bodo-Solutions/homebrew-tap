# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4320-rc/bodo-darwin-arm64"
  version "2026.1024.4320-rc"
  sha256 "309bf46fbdf45241f8f63fe54ffbe1229d714eff46841e6889952e379b284e9b"
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
      url "https://cli.bodo-app.com/v/2026.1024.4320-rc/bodo-linux-arm64"
      sha256 "c8f074ab96d7a5fd4a74c153a1b38df990394b3a26447cb053777f37a7f17d13"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4320-rc/bodo-linux-x64"
      sha256 "00e1f7772fe5f67ddd93eacb28db901bbcf927f5e72b78f33d0ab5c7d502efef"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
