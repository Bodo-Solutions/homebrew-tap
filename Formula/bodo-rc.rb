# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1028.4523-rc/bodo-darwin-arm64"
  version "2026.1028.4523-rc"
  sha256 "515a2e07d5138986ec95aa6e74cc2dea24af50c75108f63fb9a40976870f4301"
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
      url "https://cli.bodo-app.com/v/2026.1028.4523-rc/bodo-linux-arm64"
      sha256 "5af349a919f8070d024a25ab5997e8abb455f1d0f084332d4c419f037d9a441a"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1028.4523-rc/bodo-linux-x64"
      sha256 "18f7fb5db7b94fc53ac6a419b23e05cd8520c2e28ccc7c9133f105fa7595389d"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
