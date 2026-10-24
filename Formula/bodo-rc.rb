# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4333-rc/bodo-darwin-arm64"
  version "2026.1024.4333-rc"
  sha256 "268e0d53ec00187a1fa769a57eadb2172139d3f6ac72180f7cf7ac62ac587a53"
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
      url "https://cli.bodo-app.com/v/2026.1024.4333-rc/bodo-linux-arm64"
      sha256 "e717ca2640e7dcf8e49663e591bed5830ed488cdce6239118edbe8b22f71aaa9"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4333-rc/bodo-linux-x64"
      sha256 "d12f5c4c385f40d6c6b71ad9e05fe35899a04c0c713af7822c4a600217274836"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
