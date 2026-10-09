# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1009.3765-rc/bodo-darwin-arm64"
  version "2026.1009.3765-rc"
  sha256 "43285dc59a8dadd70b60b15a4f101dced93418d0e82ccccb05a563bc74421d4f"
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
      url "https://cli.bodo-app.com/v/2026.1009.3765-rc/bodo-linux-arm64"
      sha256 "bac39da7aeb9ef03c6bcbbcd97e9aa59e3c7584b6c52adc35502fc0b243dfa94"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1009.3765-rc/bodo-linux-x64"
      sha256 "732eb5c763a31d537910e501d91f53a21a876bfb4bbad64d222889f92b4fd0fa"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
