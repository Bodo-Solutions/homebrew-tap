# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1027.4478-rc/bodo-darwin-arm64"
  version "2026.1027.4478-rc"
  sha256 "e6fd29a1ed9354306e016a2cfd4b5dbdf67103f085f97d1e2327317f32c3a83e"
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
      url "https://cli.bodo-app.com/v/2026.1027.4478-rc/bodo-linux-arm64"
      sha256 "bc9dfff0be5ecd553d0f1c067fb690f67a2493a0b8608562b156225cb85c3af4"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1027.4478-rc/bodo-linux-x64"
      sha256 "5a16954c9bd48c1740ab19fec967831db7c9b68fb552d65e7f69b980191ca91e"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
