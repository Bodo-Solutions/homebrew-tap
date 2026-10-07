# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1007.3706-rc/bodo-darwin-arm64"
  version "2026.1007.3706-rc"
  sha256 "5532a54028f3c267cd6f59e62d17cb3fa2a8ba1b2eefb2f8d85292c8d0bccca5"
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
      url "https://cli.bodo-app.com/v/2026.1007.3706-rc/bodo-linux-arm64"
      sha256 "88bad44d846487948d342aa079ae1885f475eaf72ef7a4873e6e1be70c3030d2"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1007.3706-rc/bodo-linux-x64"
      sha256 "26e145fc27bab7428e9c4db6eaf4aeacd5c2af8f21a791d34874376addf4d260"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
