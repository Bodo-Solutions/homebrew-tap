# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4364-rc/bodo-darwin-arm64"
  version "2026.1024.4364-rc"
  sha256 "992e1a26e2e92b3fd3b060248ce85a51cc485cc516c0de108f1a907722002773"
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
      url "https://cli.bodo-app.com/v/2026.1024.4364-rc/bodo-linux-arm64"
      sha256 "a1b622048faa68123d00f7495c91664b072ca4816f6b57e50193c9c44ff70b8b"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4364-rc/bodo-linux-x64"
      sha256 "5cbe7ef24db949c6eaea79707fe2ac3ae04dbfa5a147db38f4387555ca0ae876"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
