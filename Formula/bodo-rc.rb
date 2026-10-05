# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1005.3614-rc/bodo-darwin-arm64"
  version "2026.1005.3614-rc"
  sha256 "35f95441b579b2e0b5aba7b6434c3a4c06ced2ee9b40376e241d04ed782b0713"
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
      url "https://cli.bodo-app.com/v/2026.1005.3614-rc/bodo-linux-arm64"
      sha256 "f2148745c525c244c33d6bff32bb1e2057cabc28c046115c72677aa4b0cfda1a"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1005.3614-rc/bodo-linux-x64"
      sha256 "9b2cb85f03b8dd3ebd15f4d570ddf2580b4f68540563d29668fc95f8444c0023"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
