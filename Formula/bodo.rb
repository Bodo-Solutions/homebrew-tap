# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1018.4060/bodo-darwin-arm64"
  version "2026.1018.4060"
  sha256 "00e34502a8bd177bf3e772916e6e5ca5dd683de933a788af6155dfe05f518344"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/stable/manifest.json"
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
      url "https://cli.bodo-app.com/v/2026.1018.4060/bodo-linux-arm64"
      sha256 "caec32fea8fea670f2e19db7297a7c34a546f70e9e0d287fd711e4fe25dcba59"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1018.4060/bodo-linux-x64"
      sha256 "65cfb606a21ba2c92c33dc0988cb78583161a35a07005bea485ee67c060c8ffa"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
