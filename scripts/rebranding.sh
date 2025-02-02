#!/bin/bash
me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

Replace() {
    # Ensure that the function is called with two arguments
    if [ "$#" -ne 2 ]; then
        echo "Usage: Replace <search-pattern> <replacement-pattern>"
        return 1
    fi

    # Define the search and replacement patterns
    local search="$1"
    local replace="$2"

    # Find files and perform the replacement
    grep -rl "$search" . \
        | grep -vE "$me|node_modules|.next|.git|.github|./out|.vscode" \
        | xargs -r sed -i '' -e "s/$search/$replace/g"
}

# Replace word in entire folder
Replace "emerald" "red"

Replace_line() {

    local file="$1"
    # Define the search and replacement patterns
    local search="$2"
    local replace="$3"

    # Find and perform the replacement
    sed -i '' -e "s/$search/$replace/g" "$file"
}
Replace_line "src/components/HeroPattern.jsx" "#36b49f" "#757272"
Replace_line "src/components/HeroPattern.jsx" "#DBFF75" "#4e5244"
Replace_line "src/app/layout.jsx" "Protocol\ API\ Reference" "Your\ Gateway\ to\ Tech\ Excellence"
Replace_line "src/components/Header.jsx" "<TopLevelNavItem href=\"\/\">API<\/TopLevelNavItem>" "<TopLevelNavItem href=\"\/devops\">DevOps<\/TopLevelNavItem>"
Replace_line "src/components/Header.jsx" "<TopLevelNavItem href=\"#\">Documentation<\/TopLevelNavItem>" "<TopLevelNavItem href=\"\/kubernetes\">Kubernetes<\/TopLevelNavItem>"
Replace_line "src/components/Header.jsx" "<TopLevelNavItem href=\"#\">Support<\/TopLevelNavItem>" "<TopLevelNavItem href=\"\/linux\">Linux<\/TopLevelNavItem>"

Replace_line "src/components/Footer.jsx" "space-y-10 pb-16 lg:max-w-5xl" "space-y-10 pb-2 lg:max-w-5xl"
Replace_line "src/components/Footer.jsx" "border-zinc-900\/5 pt-8 sm:flex-row" "border-zinc-900\/5 pt-2 sm:flex-row"
Replace_line "src/components/Navigation.jsx" "{ title: 'Quickstart', href: '\/quickstart' }," "{ title: 'DevOps', href: '\/devops' },"
Replace_line "src/components/Navigation.jsx" "{ title: 'SDKs', href: '\/sdks' }," "{ title: 'Kubernetes', href: '\/kubernetes' },"
Replace_line "src/components/Navigation.jsx" "{ title: 'Authentication', href: '\/authentication' }," "{ title: 'Linux', href: '\/linux' },\n      { title: 'Career', href: '\/career' },"
Replace_line "src/components/Navigation.jsx" "{ title: 'Contacts', href: '\/contacts' }," "{ title: 'Airflow', href: '\/airflow' },"
Replace_line "src/components/Navigation.jsx" "{ title: 'Conversations', href: '\/conversations' }," "{ title: 'Ansible', href: '\/ansible' },"

Insert() {
    local FILE="$1"
    local SEARCH_LINE="$2"
    local NEW_LINE="$3"

    # Ensure that the file path and patterns are properly escaped
    sed -i '' -e "s#${SEARCH_LINE}#${SEARCH_LINE}\n${NEW_LINE}#" "$FILE"
}

# Insert lines after the pattern match
Insert "src/app/layout.jsx" "import { Layout } from '@/components/Layout'" "import { HeroPattern } from '@/components/HeroPattern'"
Insert "src/app/layout.jsx" "<div className=\"w-full\">" "            <HeroPattern />"

delete_line() {
    local FILE="$1"
    local PATTERN="$2"

    # Use sed to delete the line containing the specified pattern
    sed -i '' -e "/${PATTERN}/d" "$FILE"
}

delete_line "src/components/mdx.jsx" "import { Feedback } from '@\/components\/Feedback'"
delete_line "src/components/mdx.jsx" "<Feedback \/>"
delete_line "src/components/Header.jsx" "import { Button } from '@\/components\/Button'"
delete_line "src/components/Navigation.jsx" "{ title: 'Pagination', href: '\/pagination' },"
delete_line "src/components/Navigation.jsx" "{ title: 'Errors', href: '\/errors' },"
delete_line "src/components/Navigation.jsx" "{ title: 'Webhooks', href: '\/webhooks' },"
delete_line "src/components/Navigation.jsx" "{ title: 'Messages', href: '\/messages' },"
delete_line "src/components/Navigation.jsx" "{ title: 'Groups', href: '\/groups' },"
delete_line "src/components/Navigation.jsx" "{ title: 'Attachments', href: '\/attachments' },"
delete_line "src/components/Navigation.jsx" "<TopLevelNavItem href=\"\/\">API<\/TopLevelNavItem>"
delete_line "src/components/Navigation.jsx" "<TopLevelNavItem href=\"#\">Documentation<\/TopLevelNavItem>"
delete_line "src/components/Navigation.jsx" "<TopLevelNavItem href=\"#\">Support<\/TopLevelNavItem>"

delete_block() {
    local FILE="$1"
    local START_PATTERN="$2"
    local END_PATTERN="$3"

    # Use an alternate delimiter to avoid escaping issues
    sed -i '' -e "/${START_PATTERN}/,/${END_PATTERN}/d" "$FILE"
}

# Example usage
delete_block "src/components/Footer.jsx" "<SocialLink href=\"#\" icon={XIcon}>" "<\/SocialLink>"
delete_block "src/components/Footer.jsx" "<SocialLink href=\"#\" icon={DiscordIcon}>" "<\/SocialLink>"
delete_block "src/components/Header.jsx" "<div className=\"hidden min-\[416px]:contents\">" "<\/div>"
delete_block "src/components/Navigation.jsx" "<li className=\"sticky bottom-0 z-10" "<\/li>"

# Use sed with an alternate delimiter

## Cleaning up files/folders from src/app
cnfig_files="attachments authentication contacts conversations errors groups messages pagination quickstart sdks webhooks"
for fname in $cnfig_files
do
echo "Deleting ${RED}$fname${NC} "
rm -rf "./src/app/$fname"
done

## Cleaning up files/folders from src/components
cnfig_files="Libraries.jsx Guides.jsx Resources.jsx Feedback.jsx"
for fname in $cnfig_files
do
echo "Deleting ${RED}$fname${NC} "
rm -rf "./src/components/$fname"
done

#
rm -rf LICENSE.md CHANGELOG.md

cat << 'EOF' > "src/app/page.mdx"

export const metadata = {
  title: 'Your Gateway to Tech Excellence',
  description:
    'We offers a wealth of information, news, and insights into the ever-evolving world of technology. Whether you are a tech enthusiast, professional, or simply curious about the latest trends, TechnoBureau provides you with a one-stop hub to stay up-to-date and explore the fascinating realm of innovation.',
}

export const sections = []

## Stay Informed, Stay Ahead

Our commitment is to deliver comprehensive and engaging content that spans various areas of interest, including the latest devops tools, emerging technologies, software and apps, internet trends, cybersecurity, artificial intelligence, and much more. With a team of experienced writers and tech experts, we curate in-depth articles, insightful reviews, and thought-provoking analysis to ensure you have access to reliable and relevant information.

## Mastering Kubernetes

Unlock the full potential of container orchestration with our in-depth coverage of Kubernetes. Dive into the intricacies of Kubernetes architecture, deployment strategies, scalability, monitoring, and management techniques. TechnoBureau equips you with the knowledge and skills to confidently design, deploy, and manage scalable and resilient applications on Kubernetes, propelling your DevOps career to new heights.

## Career Advancement

TechnoBureau is dedicated to supporting your career advancement in the Linux and DevOps domains. Our comprehensive guides, career-focused articles, and expert advice offer practical insights and strategies to help you achieve your professional goals. Whether you're aiming to land your dream job, enhance your technical skills, or transition into a DevOps role, TechnoBureau provides the guidance and resources you need to succeed.

EOF


cat << 'EOF' > "src/components/Logo.jsx"
export function Logo(props) {
  return (
    <svg viewBox="0 0 129 24" aria-hidden="true" {...props}>
      <g>
        <path
          className="fill-red-400"
          d="M16 8a5 5 0 0 0-5-5H5a5 5 0 0 0-5 5v13.927a1 1 0 0 0 1.623.782l3.684-2.93a4 4 0 0 1 2.49-.87H11a5 5 0 0 0 5-5V8Z"
        />
        <text x="25" y="15" dominantBaseline="middle" className="fill-red-400">TechnoBureau</text>
      </g>
    </svg>
  );
}
EOF