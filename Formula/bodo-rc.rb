# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1017.4011-rc/bodo-darwin-arm64"
  version "2026.1017.4011-rc"
  sha256 "f0b8f86ba6ba49f80366348dbf023f75891eeab06999902fcdc5975f62400058"
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
      url "https://cli.bodo-app.com/v/2026.1017.4011-rc/bodo-linux-arm64"
      sha256 "5f7f42c9c423e8bef0fc75f2bc7e2b4f63d23b579adbdcc6be24536a3efe1980"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1017.4011-rc/bodo-linux-x64"
      sha256 "9e141806b368eaa6105ca9e30007c9aa6012fb239211376c33b94fbae1f29b45"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
