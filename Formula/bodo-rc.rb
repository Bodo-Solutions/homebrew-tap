# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1025.4425-rc/bodo-darwin-arm64"
  version "2026.1025.4425-rc"
  sha256 "a62c901d5a5e5acf60589279183bda7aef9908bba965cfce951662ca31b1ea7e"
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
      url "https://cli.bodo-app.com/v/2026.1025.4425-rc/bodo-linux-arm64"
      sha256 "415a8c9a5410d9a258b3b077131359c7649b9d85d83396dd0452e4323541cf2a"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1025.4425-rc/bodo-linux-x64"
      sha256 "0485ffeaccc220529697962385f1567c4da86801666704a87c5e7f128e7ec0d9"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
