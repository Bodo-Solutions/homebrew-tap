# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1019.4077-rc/bodo-darwin-arm64"
  version "2026.1019.4077-rc"
  sha256 "f3164167b03bffcd54b0ae38c9d29fa4322bfd9fb1427cd92a17720a099a42bd"
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
      url "https://cli.bodo-app.com/v/2026.1019.4077-rc/bodo-linux-arm64"
      sha256 "545a395dea9852f9d8e8624fd173d8c38f657784bf71cf8688ba76ba386f9dc2"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1019.4077-rc/bodo-linux-x64"
      sha256 "06f127eeb80cf35884a2122c3e357a6f9c1d39fc8bc894ba7c45b068840e8e4c"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
