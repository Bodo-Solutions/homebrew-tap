# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1027.4484-rc/bodo-darwin-arm64"
  version "2026.1027.4484-rc"
  sha256 "f4b3d40b86179a56f4c0e4850937105159936082422a31a0243a4947b04f98aa"
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
      url "https://cli.bodo-app.com/v/2026.1027.4484-rc/bodo-linux-arm64"
      sha256 "55a4ef3dc0b9f99148f7d328fd52f8e1db625ebbbf91beb1e948dd8cfb43aa56"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1027.4484-rc/bodo-linux-x64"
      sha256 "d662e138eebe1a5f2cc0fcf9dfae17ede37d4b96a232b470165667fe31a29443"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
