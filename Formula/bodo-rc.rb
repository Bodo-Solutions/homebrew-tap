# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4334-rc/bodo-darwin-arm64"
  version "2026.1024.4334-rc"
  sha256 "245a8e59a66948283c9fcdb8879bd57dc5f48aba322a8d695664ebeb0792f45c"
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
      url "https://cli.bodo-app.com/v/2026.1024.4334-rc/bodo-linux-arm64"
      sha256 "ed8a2839cb5c4027b9fb2fba35f2a7bd0e975176d607f9baeeae6bbc830816f9"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4334-rc/bodo-linux-x64"
      sha256 "736c8e65dd7ef89e3f9eb25f9753081986f5f581c4c2b35fe5eee24fb4402945"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
