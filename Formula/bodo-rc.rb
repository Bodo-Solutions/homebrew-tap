# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1020.4117-rc/bodo-darwin-arm64"
  version "2026.1020.4117-rc"
  sha256 "a6ced4d88c5e85808bcaac9794fe1e3fad9fe23a89e60395cf3fe63367111886"
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
      url "https://cli.bodo-app.com/v/2026.1020.4117-rc/bodo-linux-arm64"
      sha256 "023fd8bac09777cf121e31c2494be4f591bff9ee8ef0b646851dcae73a45c5ba"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1020.4117-rc/bodo-linux-x64"
      sha256 "7d58998eb9ca7bb2dae0e1068addd2e2135a05ad43ea3fb880893529176ca623"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
