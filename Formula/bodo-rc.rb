# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1016.3980-rc/bodo-darwin-arm64"
  version "2026.1016.3980-rc"
  sha256 "5ad7d6bdc9596c1252fabe4610ef7e5ac0b7c3ea06382f75d86e48f9bc116822"
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
      url "https://cli.bodo-app.com/v/2026.1016.3980-rc/bodo-linux-arm64"
      sha256 "9b8bbbf0f41218e80eb7b2f732d5a7ff4ad3cb9119ecfe4f6200340c33b531c2"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1016.3980-rc/bodo-linux-x64"
      sha256 "646e67b8009d51c8f4c09ac8247c6a94d77845e22d79692661c92f4c9f3f51e4"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
