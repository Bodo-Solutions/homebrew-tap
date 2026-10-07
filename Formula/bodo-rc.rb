# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1007.3703-rc/bodo-darwin-arm64"
  version "2026.1007.3703-rc"
  sha256 "45fc4a026edfd91f0c06c0ed7bdcb706a3b645bfe6d44522a0618a40f7968d99"
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
      url "https://cli.bodo-app.com/v/2026.1007.3703-rc/bodo-linux-arm64"
      sha256 "8f5f60214b38ee2cfa7892363a6658aa86dd33bae70836fc46e715a2743fe248"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1007.3703-rc/bodo-linux-x64"
      sha256 "7c9d21c05b964f7413cc34c47164285c0a5929b43dd35454746928cfcacb9800"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
