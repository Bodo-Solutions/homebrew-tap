# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1011.3873-rc/bodo-darwin-arm64"
  version "2026.1011.3873-rc"
  sha256 "eb4f5170889ed5ade68380818e14bc8953571ce3e076d77c63a5472a7a5852ec"
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
      url "https://cli.bodo-app.com/v/2026.1011.3873-rc/bodo-linux-arm64"
      sha256 "aa12415302d8c22e356ff5a591337a117929f69180abcc549b6d962738946589"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1011.3873-rc/bodo-linux-x64"
      sha256 "1585fbc10b8f22366106df9de56ce39c77f414c9a63b47bc29b276ca084bf580"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
