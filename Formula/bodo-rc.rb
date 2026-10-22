# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1022.4261-rc/bodo-darwin-arm64"
  version "2026.1022.4261-rc"
  sha256 "3ccc03faacc61936d10788cf737b1108bf20c59410110adb77782b38f66c48df"
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
      url "https://cli.bodo-app.com/v/2026.1022.4261-rc/bodo-linux-arm64"
      sha256 "0dccc9f0f321653f751b6d0f0fd56eb380a59359e8acceb3ef519799387cbb18"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1022.4261-rc/bodo-linux-x64"
      sha256 "7fb5808441741969e212ec7e647f1c4cff34bc0882a25843b2efd573064524e3"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
