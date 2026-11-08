# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1108.4709/bodo-darwin-arm64"
  version "2026.1108.4709"
  sha256 "75dd66925d9eff5a9c2069c699c32a9da968aeeb4529f5a453f1df19f4caaea1"
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
      url "https://cli.bodo-app.com/v/2026.1108.4709/bodo-linux-arm64"
      sha256 "fa8bbbcf45bc0b8e1905c55814a6a65d5b89f370fc9607b2cb34d78af82a1ecd"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1108.4709/bodo-linux-x64"
      sha256 "705ded88f869e3560c90bf5ae5fa8496ff79b091045e62d51cf37601301aafdc"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
