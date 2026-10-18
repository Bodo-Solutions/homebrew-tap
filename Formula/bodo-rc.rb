# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1018.4046-rc/bodo-darwin-arm64"
  version "2026.1018.4046-rc"
  sha256 "ebb91c0def0b2c05e5285c2a43af244141c59b3b43351782e4e5dfb2c031ede9"
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
      url "https://cli.bodo-app.com/v/2026.1018.4046-rc/bodo-linux-arm64"
      sha256 "a7fa876b955e37b6f1c71e64ae231b530394af0fd09f1b96e7e515bddc2e19eb"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1018.4046-rc/bodo-linux-x64"
      sha256 "1b9b200893d02b1178aabfbff12ca99ad662ed8e79baac1641b3474233d41b40"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
