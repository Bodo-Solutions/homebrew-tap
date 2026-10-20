# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1020.4116-rc/bodo-darwin-arm64"
  version "2026.1020.4116-rc"
  sha256 "bd3166053532bb6b4f677d4f01d985b672576771ca785793ed93e69b6f4f1bd2"
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
      url "https://cli.bodo-app.com/v/2026.1020.4116-rc/bodo-linux-arm64"
      sha256 "ad7606e0f0059cc1ef7a30d28c58855f270547e488516532434b6cde718d39d6"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1020.4116-rc/bodo-linux-x64"
      sha256 "7c0626f50ced50159bac74807d447897ee22cd5ae5b22f93d9872e49e543be27"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
