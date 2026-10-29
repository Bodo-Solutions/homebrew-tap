# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1029.4594-rc/bodo-darwin-arm64"
  version "2026.1029.4594-rc"
  sha256 "f888d22879e739b058a23f7fcc15c658429133594434a1af7b4710ee43f5e593"
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
      url "https://cli.bodo-app.com/v/2026.1029.4594-rc/bodo-linux-arm64"
      sha256 "6f7d65022536b7a4563b173b60e037ce90c35be8872e6528a8f99cf63c5bb0ad"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1029.4594-rc/bodo-linux-x64"
      sha256 "60f9b3b6e5835cae54a57172c0f7bf50cf4041b3465858e49979f8d79f2f8cb8"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
