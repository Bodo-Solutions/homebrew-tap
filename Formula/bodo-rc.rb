# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1010.3854-rc/bodo-darwin-arm64"
  version "2026.1010.3854-rc"
  sha256 "bfce690db3084322a74af2779c9d123b99b54b04fc0d8350db1cfb04c5b9ff9f"
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
      url "https://cli.bodo-app.com/v/2026.1010.3854-rc/bodo-linux-arm64"
      sha256 "3e078c3ca116dc6eb8536a3474a3a580aa5f33df99df7bf20a6e5b3355364def"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1010.3854-rc/bodo-linux-x64"
      sha256 "6a88763c08d44e5e962dd8099e301affcc67f58a22f1a7ca7b87f4c817c25fee"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
