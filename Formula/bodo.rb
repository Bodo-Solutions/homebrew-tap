# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1007.3728/bodo-darwin-arm64"
  version "2026.1007.3728"
  sha256 "059b3f2b90eeed7c434f442bc67fd8179d620ac9173f27794c1cf0cf955962fb"
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
      url "https://cli.bodo-app.com/v/2026.1007.3728/bodo-linux-arm64"
      sha256 "1bdd793e223c3114353f1bc011b31b8f4633037f94061bfe9aea666e6ca18a03"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1007.3728/bodo-linux-x64"
      sha256 "58bc092bf19534c147678ddb0570df0f57e4e11bf387f916400298cc2e93e542"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
