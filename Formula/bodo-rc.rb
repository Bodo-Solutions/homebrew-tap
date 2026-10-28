# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1028.4515-rc/bodo-darwin-arm64"
  version "2026.1028.4515-rc"
  sha256 "7cafcd1d9bb463eb1194ed12dfca9ad400990115264fdb90bf4adf9e90f9efff"
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
      url "https://cli.bodo-app.com/v/2026.1028.4515-rc/bodo-linux-arm64"
      sha256 "f933a1e97a2323a47d67aa886ad607465d7b4fee1ffe334a5762b0f045cecfbd"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1028.4515-rc/bodo-linux-x64"
      sha256 "4fffbabf2a7e0fefafa12c694e5c59c0d19ca5b9c2064ac353a559cab956ead4"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
