# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1101.4689/bodo-darwin-arm64"
  version "2026.1101.4689"
  sha256 "f51b2fe5fcb2f8ea56f690f0723f67393a60c678fc0a5f1797f89e50297043f3"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/stable/manifest.json"
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
      url "https://cli.bodo-app.com/v/2026.1101.4689/bodo-linux-arm64"
      sha256 "d16f76b31a3476771faa2cc74defd36ad99a7de836a445da32e172a4cd613059"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1101.4689/bodo-linux-x64"
      sha256 "32656dde2719e6e62e352ac6bdff68142983566320e6e34fa9cdebae70978d6d"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
