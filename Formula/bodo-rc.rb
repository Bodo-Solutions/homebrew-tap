# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1026.4467-rc/bodo-darwin-arm64"
  version "2026.1026.4467-rc"
  sha256 "d243583ee2f3aaa56366d352df5cc4da4da6384d117d9978cdb4049d260d86cf"
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
      url "https://cli.bodo-app.com/v/2026.1026.4467-rc/bodo-linux-arm64"
      sha256 "ccb2963b06b31e3e895290079e70831fcc420c35ec854f407b1d11b65d24178b"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1026.4467-rc/bodo-linux-x64"
      sha256 "f977cf86c7411d479a458fbfabec81463047de261c9c439ad55250d1bbf2b3cd"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
